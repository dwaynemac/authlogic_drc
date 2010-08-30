module AuthlogicDRC
  module Session
    def self.included(klass)
      klass.class_eval do
        include Methods
      end
    end

    module Methods
      def self.included(klass)
        klass.class_eval do
          persist.reject{|cb| [:persist_by_params,:persist_by_session,:persist_by_http_auth].include?(cb.method)}
          persist :persist_by_drc, :if => :authenticating_with_drc?
        end
      end

      # no credentials are passed in: the CAS server takes care of that and saving the session
      # def credentials=(value)
      #   values = [:garbage]
      #   super
      # end

      def persist_by_cas
        session_key = CASClient::Frameworks::Rails::Filter.client.username_session_key # TODO wrap in DRCClient

        unless controller.session[session_key].blank?
          self.attempted_record = search_for_record("find_by_#{klass.login_field}", controller.session[session_key])
        end
        !self.attempted_record.nil?
      end

      def authenticating_with_drc?
        attempted_record.nil? && errors.empty? && drc_defined?
      end

      private

      #todo: validate that cas filters have run.  Authlogic controller adapter doesn't provide access to the filter_chain
      def drc_defined?
        defined?(DRCClient) && !DRCClient.config.nil?
      end
    end
  end
end
