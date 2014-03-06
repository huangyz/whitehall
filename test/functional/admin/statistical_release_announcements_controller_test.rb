require 'test_helper'

class Admin::StatisticalReleaseAnnouncementsControllerTest < ActionController::TestCase
  setup do
    @user = login_as(:policy_writer)
    @organisation = create(:organisation)
    @topic = create(:topic)
  end

  view_test "GET :new renders a new announcement form" do
    get :new

    assert_response :success
    assert_select "input[name='statistical_release_announcement[title]']"
  end

  test "POST :create saves the announcement to the database and redirects to the dashboard" do
    post :create, statistical_release_announcement: {
                    title: 'Beard stats 2014',
                    summary: 'Summary text',
                    publication_type_id: PublicationType::Statistics.id,
                    organisation_id: @organisation.id,
                    topic_id: @topic.id,
                    expected_release_date: 1.year.from_now }

    assert_redirected_to admin_root_url
    assert announcement = StatisticalReleaseAnnouncement.last
    assert_equal 'Beard stats 2014', announcement.title
    assert_equal @organisation, announcement.organisation
    assert_equal @user, announcement.creator
  end

  view_test "POST :create re-renders the form if the announcement is invalid" do
    post :create, statistical_release_announcement: { title: '', summary: 'Summary text' }

    assert_response :success
    assert_select "ul.errors li", text: "Title can&#x27;t be blank"
    refute StatisticalReleaseAnnouncement.any?
  end

  view_test "GET :edit renders the edit form for the  announcement" do
    announcement = create(:statistical_release_announcement)
    get :edit, id: announcement.id

    assert_response :success
    assert_select "input[name='statistical_release_announcement[title]'][value='#{announcement.title}']"
  end

  test "PUT :update saves changes to the announcement" do
    announcement = create(:statistical_release_announcement)
    put :update, id: announcement.id, statistical_release_announcement: { title: "New announcement title" }

    assert_redirected_to admin_root_url
    assert_equal 'New announcement title', announcement.reload.title
  end

  view_test "PUT :update re-renders edit form if changes are not valid" do
    announcement = create(:statistical_release_announcement)
    put :update, id: announcement.id, statistical_release_announcement: { title: '' }

    assert_response :success
    assert_select "ul.errors li", text: "Title can&#x27;t be blank"
  end

  test "DELETE :destroy deletes the announcement" do
    announcement = create(:statistical_release_announcement)
    delete :destroy, id: announcement.id

    assert_redirected_to admin_root_url
    refute StatisticalReleaseAnnouncement.exists?(announcement)
    assert_equal "Announcement deleted successfully", flash[:notice]
  end
end