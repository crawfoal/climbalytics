# you must set up the http_request_proc to use this

shared_examples_for 'a request for a unauthorized action' do |http_request_method_name|

  alias_method :http_request_proc, http_request_method_name

  before :each do
    request.env["HTTP_REFERER"] ||= "/where_i_came_from"
    http_request_proc.call
  end

  it 'displays a flash message' do
    expect(flash[:alert]).to eq "You are not authorized to perform this action."
  end

  it 'redirects back' do
    expect(response).to redirect_to request.env["HTTP_REFERER"]
  end

end
