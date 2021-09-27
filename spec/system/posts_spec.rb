# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let!(:post){create(:post, title:'hoge', description:"description")}
  describe 'トップ画面(homes_top_path)のテスト' do
    before do
      visit homes_top_path
    end
    context'表示の確認'do
      it 'トップ画面(homes_top_path)にLearn Languageが表示されているか' do
        expect(page).to have_content'Learn Language'
      end 
      it 'homes_top_pathが"homes/top"であるか' do
        expect(current_path).to eq('homes/top')
      end
    end
  end
