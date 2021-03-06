 defmodule HelloWeb.Auth do
 	import Plug.Conn
 
   import Phoenix.Controller
 
   alias HelloWeb.Router.Helpers, as: Routes

 	def init(opts), do: opts
 
# 	def call(conn, _opts) do
# 		user_id = get_session(conn, :user_id)
# 		user = user_id && Hello.Accounts.get_user(user_id)
# 		assign(conn, :current_user, user)
# 	end

 	def call(conn, _opts) do
 		user_id = get_session(conn, :user_id)
 		#user = user_id && Hello.Accounts.get_user(user_id)
 		#assign(conn, :current_user, user)

	     cond do
	       conn.assigns[:current_user] ->
	         conn
	 
	       user = user_id && Hello.Accounts.get_user(user_id) ->
	         #assign(conn, :current_user, user)
	         put_current_user(conn, user)
	 
	       true ->
	         assign(conn, :current_user, nil)
	     end
 		
 	end
 
 	defp put_current_user(conn, user) do
 		token = Phoenix.Token.sign(conn, "user socket", user.id)

 		conn
 		|> assign(:current_user, user)
 		|> assign(:user_token, token)
 	end

 	def login(conn, user) do
 		conn
 		|> assign(:current_user, user)
 		|> put_session(:user_id, user.id)
 		|> configure_session(renew: true)
 	end
 
 	def logout(conn) do
 		#configure_session(conn, drop: true)
 
 		delete_session(conn, :user_id)
 	end
 
# 	import Phoenix.Controller
# 	alias HelloWeb.Router.Helpers, as: Routes
 
 	def authenticate_user(conn, _opts) do
 		if conn.assigns.current_user do
 			conn
 		else
 			conn
 				|> put_flash(:error, "You must be logged in to access that page")
 				|> redirect(to: Routes.page_path(conn, :index))
 				|> halt()
 		end
 	end
 
 
 
 def call(conn, _opts) do
 	user_id = get_session(conn, :user_id)
 
 	cond do
 		conn.assigns[:current_user] ->
 			conn
 
 		user = user_id && Hello.Accounts.get_user(user_id) ->
 			assign(conn, :current_user, user)
 		true ->
 			assign(conn, :current_user, nil)
 	end
 end
 
 
 
 end


# defmodule HelloWeb.Auth do
#   import Plug.Conn
#   import Phoenix.Controller
# 
#   alias HelloWeb.Router.Helpers, as: Routes
# 
#   def init(opts), do: opts
# 
#   def call(conn, _opts) do
#     user_id = get_session(conn, :user_id)
# 
#     cond do
#       conn.assigns[:current_user] ->
#         conn
# 
#       user = user_id && Hello.Accounts.get_user(user_id) ->
#         assign(conn, :current_user, user)
# 
#       true ->
#         assign(conn, :current_user, nil)
#     end
#   end
# 
#   def login(conn, user) do
#     conn
#     |> assign(:current_user, user)
#     |> put_session(:user_id, user.id)
#     |> configure_session(renew: true)
#   end
# 
#   def logout(conn) do
#     configure_session(conn, drop: true)
#   end
# 
# 
#   def authenticate_user(conn, _opts) do
#     if conn.assigns.current_user do
#       conn
#     else
#       conn
#       |> put_flash(:error, "You must be logged in to access that page")
#       |> redirect(to: Routes.page_path(conn, :index))
#       |> halt()
#     end
#   end
# end
