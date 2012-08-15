# The backdat exception list.
module Backdat::Exceptions
  # Access is denied to the requested resource.
  class AccessDenied < RuntimeError; end

  # Erroenous HTTP response from a request.
  class HTTPError < RuntimeError; end
end
