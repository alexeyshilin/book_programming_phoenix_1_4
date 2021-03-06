defmodule Hello.MultimediaTest do
  #use Hello.DataCase
  use Hello.DataCase, async: true

  alias Hello.Multimedia
  alias Hello.Multimedia.Category

#  describe "videos" do
#    alias Hello.Multimedia.Video
#
#    @valid_attrs %{description: "some description", title: "some title", url: "some url"}
#    @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url"}
#    @invalid_attrs %{description: nil, title: nil, url: nil}
#
#    def video_fixture(attrs \\ %{}) do
#      {:ok, video} =
#        attrs
#        |> Enum.into(@valid_attrs)
#        |> Multimedia.create_video()
#
#      video
#    end
#
#    test "list_videos/0 returns all videos" do
#      video = video_fixture()
#      assert Multimedia.list_videos() == [video]
#    end
#
#    test "get_video!/1 returns the video with given id" do
#      video = video_fixture()
#      assert Multimedia.get_video!(video.id) == video
#    end
#
#    test "create_video/1 with valid data creates a video" do
#      assert {:ok, %Video{} = video} = Multimedia.create_video(@valid_attrs)
#      assert video.description == "some description"
#      assert video.title == "some title"
#      assert video.url == "some url"
#    end
#
#    test "create_video/1 with invalid data returns error changeset" do
#      assert {:error, %Ecto.Changeset{}} = Multimedia.create_video(@invalid_attrs)
#    end
#
#    test "update_video/2 with valid data updates the video" do
#      video = video_fixture()
#      assert {:ok, %Video{} = video} = Multimedia.update_video(video, @update_attrs)
#      assert video.description == "some updated description"
#      assert video.title == "some updated title"
#      assert video.url == "some updated url"
#    end
#
#    test "update_video/2 with invalid data returns error changeset" do
#      video = video_fixture()
#      assert {:error, %Ecto.Changeset{}} = Multimedia.update_video(video, @invalid_attrs)
#      assert video == Multimedia.get_video!(video.id)
#    end
#
#    test "delete_video/1 deletes the video" do
#      video = video_fixture()
#      assert {:ok, %Video{}} = Multimedia.delete_video(video)
#      assert_raise Ecto.NoResultsError, fn -> Multimedia.get_video!(video.id) end
#    end
#
#    test "change_video/1 returns a video changeset" do
#      video = video_fixture()
#      assert %Ecto.Changeset{} = Multimedia.change_video(video)
#    end
#  end



describe "categories" do
  test "list_alphabetical_categories/0" do
    for name <- ~w(Drama Action Comedy) do
      Multimedia.create_category!(name)
    end
  
  alpha_names =
    for %Category{name: name} <-
      Multimedia.list_alphabetical_categories() do
      name
    end
  
    #assert alpha_names == ~w(Action Comedy Drama)
    assert alpha_names == ~w(Action Comedy Drama Romance Sci-fi)
  end
end





  describe "videos" do
    alias Hello.Multimedia.Video

    @valid_attrs %{description: "desc", title: "title", url: "http://local"}
    @invalid_attrs %{description: nil, title: nil, url: nil}

    test "list_videos/0 returns all videos" do 
      owner = user_fixture()
      %Video{id: id1} = video_fixture(owner)
      assert [%Video{id: ^id1}] = Multimedia.list_videos()
      %Video{id: id2} = video_fixture(owner)
      assert [%Video{id: ^id1}, %Video{id: ^id2}] = Multimedia.list_videos()
    end

    test "get_video!/1 returns the video with given id" do 
      owner = user_fixture()
      %Video{id: id} = video_fixture(owner)
      assert %Video{id: ^id} = Multimedia.get_video!(id)
    end

     test "create_video/2 with valid data creates a video" do 
       owner = user_fixture()
       
       assert {:ok, %Video{} = video} = 
         Multimedia.create_video(owner, @valid_attrs)
         
       assert video.description == "desc"
       assert video.title == "title"
       assert video.url == "http://local"
     end

     test "create_video/2 with invalid data returns error changeset" do 
       owner = user_fixture()
       assert {:error, %Ecto.Changeset{}} = 
         Multimedia.create_video(owner, @invalid_attrs)
     end

     test "update_video/2 with valid data updates the video" do 
       owner = user_fixture()
       video = video_fixture(owner)
       assert {:ok, video} = 
         Multimedia.update_video(video, %{title: "updated title"})
       assert %Video{} = video
       assert video.title == "updated title"
     end

     test "update_video/2 with invalid data returns error changeset" do 
       owner = user_fixture()
       %Video{id: id} = video = video_fixture(owner)
       
       assert {:error, %Ecto.Changeset{}} = 
         Multimedia.update_video(video, @invalid_attrs)
         
       assert %Video{id: ^id} = Multimedia.get_video!(id)
     end

     test "delete_video/1 deletes the video" do 
       owner = user_fixture()
       video = video_fixture(owner)
       assert {:ok, %Video{}} = Multimedia.delete_video(video)
       assert Multimedia.list_videos() == []
     end

     test "change_video/1 returns a video changeset" do 
       owner = user_fixture()
       video = video_fixture(owner)
       assert %Ecto.Changeset{} = Multimedia.change_video(video)
     end
  end



end


# mix test test/hello/multimedia_test.exs

