cvlc --loop /users/qw/GECSports.mp4 -vvv --sout '#transcode{vcodec=mp4v,vb=1024,ab=128,fps=20,vfilter=canvas{width=800,height=600,aspect=4:3}}:duplicate{dst=std{access=udp,caching="300",mux="ts",dst=10.10.2.3:32003}}' &





