class CanonicalizeHost
  def initialize(app, *args)
    @app = app
  end

  def call(env)
    if env['HTTP_HOST'] =~ /^civbounty.com/
      [302, {'Location' => "#{ env['rack.url_scheme'] }://www.civbounty.com#{ env['REQUEST_URI'] }"}, 'These are not the droids you were looking for']
    else
      @app.call(env)
    end
  end
end

