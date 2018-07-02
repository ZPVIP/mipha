defmodule Mipha.Topics.Topic do
  @moduledoc false

  use Ecto.Schema
  import Ecto.{Changeset, Query}

  alias Mipha.{
    Repo,
    Topics,
    Accounts,User,
    Replies.Reply
  }

  alias Topics.{Topic, Node}

  @type t :: %Topic{}

  schema "topics" do
    field :title, :string
    field :body, :string
    field :type, :string
    field :closed_at, :naive_datetime
    field :replied_at, :naive_datetime
    field :suggested_at, :naive_datetime
    field :reply_count, :integer
    field :visit_count, :integer

    belongs_to :user, User
    belongs_to :node, Node
    belongs_to :last_reply, Reply, foreign_key: :last_reply_id
    belongs_to :last_reply_user, User, foreign_key: :last_reply_user_id

    has_many :replies, Reply

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    permitted_attrs = ~w(
      title
      body
      closed_at
      user_id
      type
      node_id
      visit_count
      reply_count
      last_reply_id
      last_reply_user_id
      replied_at
      suggested_at
    )a

    required_attrs = ~w(
      title
      body
      node_id
      user_id
    )a

    topic
    |> cast(attrs, permitted_attrs)
    |> validate_required(required_attrs)
  end
end