#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and https://www.varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "127.0.0.1";
    .port = "8080";
    .connect_timeout = 2s;
    .first_byte_timeout = 2s;
    .between_bytes_timeout = 2s;
}
sub vcl_recv {
    if (req.method == "PURGE") {
    return (purge);
    }
    if (req.method == "CLEANFULLCACHE") {
    ban("req.http.host ~ .*");
    return (synth(200, "Full cache cleared"));
    }
    if (req.method != "GET" && req.method != "HEAD") {
        return (pass);
    }
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
    if (bereq.method != "GET" && bereq.method !="HEAD") {
                 set beresp.uncacheable = true;
                 set beresp.uncacheable = 120s;
                 return(deliver);
    }
    #set beresp.grace = 12h;
    #set beresp.ttl = 12h;

    if (bereq.url ~ "\.(css|js|png|gif|svg|jp(e?)g)|swf|ico|woff(2?)") {
                unset beresp.http.cookie;
                set beresp.storage_hint = "static";
                set beresp.http.x-storage = "static";
        } else {
                set beresp.storage_hint = "default";
                set beresp.http.x-storage = "default";
        }
}

sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.x-cache = "HIT";
    } else {
        set resp.http.x-cache = "MISS";
    }

    # Remove some headers: Nginx version & OS
    #unset resp.http.Via;
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}
