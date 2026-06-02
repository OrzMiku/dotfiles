function proxyon
    set -l port 7890

    if test (count $argv) -gt 0
        set port $argv[1]
    end

    set     -gx http_proxy  "http://127.0.0.1:$port"
    set     -gx https_proxy "http://127.0.0.1:$port"
    set     -gx all_proxy   "socks5://127.0.0.1:$port"
    echo    -e  "proxy on $port!"
end
