defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussions
  alias Discuss.Discussions.Topic

  def index(conn, _params) do
    topics = Discussions.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Discussions.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Discussions.create_topic(topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Discussions.get_topic!(topic_id)
    changeset = Topic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Discussions.get_topic!(topic_id)

    case Discussions.update_topic(old_topic, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    old_topic = Discussions.get_topic!(topic_id)

    case Discussions.delete_topic(old_topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Deleted")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: Routes.topic_path(conn, :index))
    end
  end
end
