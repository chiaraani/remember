require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe WordsController, type: :controller do
 let(:word) { create(:word) }

  # As you add validations to Word, be sure to
  # adjust the attributes here as well.

  let(:invalid_attributes) {
    {spelling: 'apple'}
  }

  before { @double = create :word, spelling: 'apple'}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WordsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      word
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: word.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: word.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let :route do
        post :create,
          params: {word: attributes_for(:word)},
          session: valid_session
      end
      it "creates a new Word" do
        expect { route }.to change(Word, :count).by(1)
      end

      it "redirects to the created word" do
        route
        expect(response).to redirect_to(Word.last)
      end

      context "with review=true" do
        it "creates a review" do
          expect do
            post :create,
              params: {word: attributes_for(:word), review: "on"},
              session: valid_session
          end.to change(Review, :count).by(1)
        end
      end
   end

    context "with invalid params" do
      let(:route) { post :create, params: {word: invalid_attributes}, session: valid_session }
      it "returns a success response (i.e. to display the 'new' template)" do
        route
        expect(response).to be_successful
        expect(response).to render_template('words/new')
      end

      it 'creates review for double word' do
        expect { route }.to change(@double.reviews, :count).by(1)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {spelling: 'oyster'} }
      before do
        put :update, params: {id: word.to_param, word: new_attributes}, session: valid_session
      end

      it "updates the requested word" do
        word.reload
        expect(word.spelling).to match('oyster')
      end

      it("redirects to the word") { expect(response).to redirect_to(word) }
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: word.to_param, word: invalid_attributes}, session: valid_session
        expect(response).to be_successful
        expect(response).to render_template('words/edit')
      end
    end
  end

  describe "DELETE #destroy" do
    let(:route) { delete :destroy, params: {id: word.to_param}, session: valid_session }
    it "destroys the requested word" do
      word
      expect { route }.to change(Word, :count).by(-1)
    end

    it "redirects to the words list" do
      route
      expect(response).to redirect_to(words_url)
    end

    it "calls should_postpone on its defined" do
      defined1 = word.defined.create(attributes_for(:word, postpone: true))
      defined2 = word.defined.create(attributes_for(:word, postpone: true))
      route
      expect(defined1.reload.postpone).to be false
      expect(defined2.reload.postpone).to be false
    end
  end
end
