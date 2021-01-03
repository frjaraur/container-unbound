Small and useful unbound built on alpine. 
This image should use with external /etc/unbound/unbound.conf

Example unbound.conf for a simple forward caching DNS
~~~
server:
    interface: 0.0.0.0
        access-control: 0.0.0.0/0 allow 
        verbosity: 1
    local-data: "ten.zero.zero.one. A 10.0.0.1"
    local-data-ptr: "10.0.0.1 ten.zero.zero.one."
    local-data: "ten.zero.zero.two. A 10.0.0.2"
    local-data-ptr: "10.0.0.2 ten.zero.zero.two."
    local-data: "ten.zero.zero.three. A 10.0.0.3"
    local-data-ptr: "10.0.0.3 ten.zero.zero.three."

forward-zone:
      name: "."
      forward-addr: 8.8.4.4        # Google
      forward-addr: 8.8.8.8        # Google
~~~
Sample usage, exporting on 20053 tcp and udp:
~~~

docker run -d --name unbound \
-p20053:53/udp \
-p20053:53/tcp \
--restart always \
--read-only \
-v $(pwd)/unbound.conf:/etc/unbound/unbound.conf \
-v $(pwd)/localrecords.conf:/etc/unbound/localrecords.conf \
frjaraur/unbound:latest
~~~
