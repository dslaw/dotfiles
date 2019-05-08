function docker-repl
    set -l container $argv[1]
    docker run \
        -it \
        --rm \
        --user=(id -u (whoami)) \
        --volume=$PWD:/usr/src/app \
        $container \
        bash
end
