require 'spec_helper'

	describe "Static pages" do

	 subject { page }

	describe "Home page" do
		before { visit root_path}

		#this would be a good spot to test for logo
	  it { should have_selector('title',     text: full_title('')) }
	  it { should_not have_selector('title', text: '| Home') }

	  describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
      describe "as an admin user" do
				let(:admin) {FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit root_path
				end

				it { should have_link('Create user', href: signup_path) }
			end		

      # describe "follower/following counts" do
      #   let(:other_user) { FactoryGirl.create(:user) }
      #   before do
      #     other_user.follow!(user)
      #     visit root_path
      #   end

      #   it { should have_link("0 following", href: following_user_path(user)) }
      #   it { should have_link("1 followers", href: followers_user_path(user)) }
      # end
    end
  end

	describe "Help page" do
		before { visit help_path }
		
	  it { should have_selector('h1',    text: 'Help') }
	  it { should have_selector('title', text: full_title('Help')) }
	end

	describe "About page" do
		before { visit about_path }
		
		it { should have_selector('h1',    text: 'About us') }
	  it { should have_selector('title', text: full_title('About us')) }
	end

	describe "Contact page" do
		before { visit contact_path }
		
		it { should have_selector('h1',    text: 'Contact') }
	  it { should have_selector('title', text: full_title('Contact')) }
	end

	it "should have the right links in the layout" do
		visit root_path
		click_link "Sign in"
		page.should have_selector 'title', text: full_title('Sign in')
		click_link "About"
		page.should have_selector 'title', text: full_title('About us')
		click_link "Help"
		page.should have_selector 'title', text: full_title('Help')				
		click_link "Contact"
		page.should have_selector 'title', text: full_title('Contact')
		click_link "Home"
		click_link "tty"
		
		end
end
