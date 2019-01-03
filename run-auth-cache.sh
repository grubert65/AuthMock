cd /Users/mmi59/sky-uk/go/src/github.com/grubert65/CacheMock
plackup -p 8100 bin/app.psgi > cacheMock.log 2>&1 &

cd /Users/mmi59/sky-uk/go/src/github.com/grubert65/AuthMock
plackup -p 8080 bin/app.psgi > AuthMock.log 2>&1 &

