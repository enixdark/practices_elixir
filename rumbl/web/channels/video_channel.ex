require IEx
defmodule Rumbl.VideoChannel do
  use Rumbl.Web, :channel

  def join("videos:" <> video_id, params, socket) do
    last_seen_id = params["last_seen_id"] || 0
    video_id = String.to_integer(video_id)
    video = Repo.get!(Rumbl.video, video_id)

    annotations = Repo.all(from a in assoc(video, :annotations),
                          where: a.id > ^last_seen_id,
                          order_by: [asc: a.at, asc: a.id],
                          limit: 200,
                          preload: [:user])
    resp = %{annotations: Phoenix.View.render_many(annotations, Rumbl.AnnotationView, "annotation.json")}
    {:ok, resp, assign(socket, :video_id, video_id)}
  end
  def join("videos:" <> video_id, _param, socket) do
    {:ok, assign(socket, :video_id, String.to_integer(video_id))}

    video_id = String.to_integer(video_id)
    video = Repo.get!(Rumbl.Video, video_id)

    annotations = Repo.all(from a in assoc(video, :annotations),
                           order_by: [asc: a.at, asc: a.id],
                           limit: 200,
                           preload: [:user]
    )

    resp = %{annotations: Phoenix.View.render_many(annotations, Rumbl.AnnotationView,
              "annotation.json")}
    {:ok, resp, assign(socket, :video_id, video_id)}
    #:timer.send_interval(5_000, :ping)
    #{:ok, socket}
  end

  #def handle_info(:ping, socket) do
  #  count = socket.assigns[:count] || 1
  #  push socket, "ping", %{count: count}
  #
  #  {:noreply, assign(socket, :count, count + 1)}
  #end

  def handle_in(event, params, socket) do
    user = Repo.get(Rumbl.User, socket.assigns.user_id)
    handle_in(event, params, user,socket)
  end


  def handle_in("new_annotation", params, user, socket) do
    #broadcast! socket, "new_annotation", %{
    #  user: %{username: "anon"},
    #  body: params["body"],
    #  at: params["at"]
    #}

    changeset = user |> build_assoc(:annotations, video_id: socket.assigns.video_id)
                     |> Rumbl.Annotation.changeset(params)
    case Repo.insert(changeset) do
      {:ok, annotation} ->
        broadcast! socket, "new_annotation", %{
          id: annotation.id,
          user: Rumbl.UserView.render("user.json", %{user: user}),
          body: annotation.body,
          at: annotation.at
        }
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, %{errors: changeset}, socket}
    end

  end
end