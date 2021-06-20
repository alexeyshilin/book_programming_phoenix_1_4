
export PATH="$PATH:/usr/local/share/libs/elixir-1.11.4/bin"

MIX_ENV=dev /usr/local/share/libs/elixir-1.11.4/bin/mix phx.gen.schema Multimedia.Annotation annotations body:text at:integer user_id:references:users video_id:references:videos


mix phx.gen.presence





cp test/test_helper.exs test/support/test_helpers.ex
cd ../

/usr/local/share/libs/elixir-1.11.4/bin/mix phx.new hello --umbrella


cp -R hello/lib/hello hello_umbrella/apps/hello/lib
cp hello/lib/hello.ex hello_umbrella/apps/hello/lib
cp -R hello/test/hello hello_umbrella/apps/hello/test
cp -R hello/priv/repo hello_umbrella/apps/hello/priv
cp hello/test/support/data_case.ex hello_umbrella/apps/hello/test/support
cp hello/test/support/test_helpers.ex hello_umbrella/apps/hello/test/support


cp -R hello/lib/hello_web hello_umbrella/apps/hello_web/lib
cp hello/lib/hello_web.ex hello_umbrella/apps/hello_web/lib
cp -R hello/test/hello_web hello_umbrella/apps/hello_web/test
cp hello/test/support/conn_case.ex hello_umbrella/apps/hello_web/test/support

cp -R hello/assets/js hello_umbrella/apps/hello_web/assets/
cp -R hello/assets/css hello_umbrella/apps/hello_web/assets/

cd ./hello_umbrella
mix deps.get


MIX_ENV=dev /usr/local/share/libs/elixir-1.11.4/bin/mix phx.server

MIX_ENV=dev /usr/local/share/libs/elixir-1.11.4/bin/mix test
sudo PATH="$PATH:/usr/local/share/libs/elixir-1.11.4/bin" MIX_ENV=test SECRET=some /usr/local/share/libs/elixir-1.11.4/bin/mix test
