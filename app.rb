require 'oauth2'
require 'sinatra/base'
require 'sinatra/respond_with'

module Haptic
  class Web < Sinatra::Base

    configure do
      use Rack::Session::Cookie, :secret => Digest::SHA1.hexdigest(rand.to_s)
    end

    before do
      @free_agent_client = OAuth2::Client.new(ENV['FREE_AGENT_KEY'], ENV['FREE_AGENT_SECRET'], {
        site: 'https://api.freeagent.com/v2/',
        authorize_url: 'approve_app',
        token_url: 'token_endpoint',
        connection_opts: { headers: { user_agent: 'haptic', :accept => 'application/json', :content_type => 'application/json' } }
      })
    end

    get '/' do
      erb :index
    end

    get '/freeagent' do
      if session[:access_token]
        @projects = token.get('https://api.freeagent.com/v2/projects').parsed['projects']
        erb :freeagent
      else
        redirect '/auth/freeagent'
      end
    end

    get '/freeagent/project' do
      project_url = params[:url]
      @project = token.get(project_url).parsed['project']
      puts "https://api.freeagent.com/v2/invoices?project=#{project_url}"
      @invoices = token.get("https://api.freeagent.com/v2/invoices?project=#{project_url}").parsed['invoices']
      erb :project
    end

    get '/auth/freeagent' do
      redirect @free_agent_client.auth_code.authorize_url(:redirect_uri => redirect_uri) # :access_type => "offline"
    end

    get '/auth/freeagent/callback' do
      access_token = @free_agent_client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
      session[:access_token] = access_token.token
      redirect '/freeagent'
    end

    def redirect_uri
      uri = URI.parse(request.url)
      uri.path = '/auth/freeagent/callback'
      uri.query = nil
      uri.to_s
    end

    def token
      OAuth2::AccessToken.new(@free_agent_client, session[:access_token])
    end
  end
end
