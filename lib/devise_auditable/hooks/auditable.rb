Warden::Manager.after_set_user :except => :fetch do |record, warden, opts|
  if record.respond_to?(:audit_login!) && warden.authenticated?(opts[:scope]) && !warden.request.env['devise.skip_trackable']
    record.audit_login!(warden.request)
  end
end

Warden::Manager.before_logout do |record, warden, opts|
  if record.respond_to?(:audit_logout!) && !warden.request.env['devise.skip_trackable']
    record.audit_logout!(warden.request)
  end
end
