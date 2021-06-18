
export PATH="$PATH:/usr/local/share/libs/elixir-1.11.4/bin"

MIX_ENV=dev /usr/local/share/libs/elixir-1.11.4/bin/mix phx.gen.schema Multimedia.Annotation annotations body:text at:integer user_id:references:users video_id:references:videos


mix phx.gen.presence
