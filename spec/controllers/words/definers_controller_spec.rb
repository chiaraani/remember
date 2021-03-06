require 'rails_helper'

RSpec.describe Words::DefinersController, type: :controller do
  let(:word) { create(:word) }
  let(:definer) { create(:word) }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it "returns a success response" do
      word
      get :index, params: {word_id: word.to_param}, session: valid_session
      expect(response).to be_successful
    end    
  end

  describe 'POST #create' do
    def route new_definer
      post :create,
        params: {word_id: word.to_param, word: {new_definer: new_definer}},
        session: valid_session
    end

    context "with valid params" do
      before { route(definer.spelling) }

      it "adds the new definer" do
        word.reload
        expect(word.definers).to include(definer)
      end

      it("redirects to the word") { expect(response).to redirect_to(word_definers_path(word)) }

      it "executes word's method 'should_postpone'" do
        expect(word.reload.postpone).to be_truthy
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the word 'show' template)" do
        route('')
        expect(response).to be_successful
        expect(response).to render_template('words/definers/index')
      end
    end
  end

  describe 'DELETE #destroy' do
    def route
      delete :destroy, params: {word_id: word.to_param, id: definer.to_param}, session: valid_session
    end

    before { word.definers << definer }

    it 'destroys association between words' do
      expect { route }.to change(word.definers, :count).by(-1)
    end

    it "redirects to the words list" do
      route
      expect(response).to redirect_to(word_definers_path(word))
    end

    it "executes word's method 'should_postpone'" do
      word.update(postpone: true)
      route
      expect(word.reload.postpone).to be false
    end
  end
end