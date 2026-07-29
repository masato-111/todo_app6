require "rails_helper"

RSpec.describe "教授レビュー管理", type: :system do
    # 教授レビューを新規投稿できる
    # 教授名が空の場合は投稿できない
    # 画像を添付して新規投稿ができる
    describe "教授レビューの新規投稿" do
        context '教授名が空じゃないとき' do
            it '新規投稿ができる' do
                # 新規投稿画面を開く
                visit new_professor_path
                # titleに入力する
                fill_in "title", with: "末柄真翔"
                # descriptionに入力する
                fill_in "description", with: "単位が取りやすいです"
                # Create Professorをクリックする
                click_on "Create Professor", exact:true
                # 投稿が成功したことを確認する
                expect(page).to have_content "末柄真翔"
            end
            it '画像を添付して新規投稿ができる' do
                # 新規投稿画面を開く
                visit new_professor_path
                # titleに入力する
                fill_in "title", with: "末柄真翔"
                # descriptionに入力する
                fill_in "description", with: "楽に単位が取れます"
                # 画像ファイルを選ぶ
                image_path = Rails.root.join('spec/fixtures/files/test_image.png')
                attach_file("professor[image]", image_path, make_visible: true)
                # Create Professorをクリックする
                click_on "Create Professor", exact: true
                # 投稿が成功したことを確認する
                visit professor_path(Professor.last)
                expect(page).to have_selector "img[src*='test_image.png']"
            end
        end
        context '教授名が空のとき' do
            it '新規投稿ができない' do
                # 新規投稿画面を開く
                visit new_professor_path
                # titleを入力しない
                fill_in "title", with: ""
                # descriptionに入力する
                fill_in "description", with: "楽に単位が取れます"
                # Create Professorをクリックする
                click_on "Create Professor", exact: true
                # 登録ができていないことを確認する
                expect(page).to have_button "Create Professor"
            end
        end
    end
        
    # 教授一覧に投稿された教授レビューを表示できる
    describe "教授一覧の表示" do
      #テストデータを事前に用意する
      let!(:professor) {FactoryBot.create(:professor, title:"末柄真翔", description:"楽に単位が取れます")}
      it "教授一覧に投稿された教授レビューを表示できる" do
        #教授一覧に移動する
        visit professors_path
        #教授名があるかどうか確認する
        expect(page).to have_content "末柄真翔"
      end
    end
    # 教授一覧から教授詳細を表示できる
    describe "一覧から詳細への遷移" do
      #テストデータを事前に用意する
      let!(:professor) {FactoryBot.create(:professor, title:"末柄真翔", description:"楽に単位が取れます")}
      it "教授一覧から教授詳細を表示できる" do
        #教授一覧に移動する
        visit professors_path
        #教授名をクリック
        click_on "末柄真翔"
        #教授詳細画面に遷移したかどうか確認する
        expect(page).to have_content "楽に単位が取れます"
      end
    end
    # 教授詳細に教授名と説明を表示できる
    describe "教授詳細画面の表示" do
      #テストデータを事前に用意する
      let(:professor) {FactoryBot.create(:professor, title:"末柄真翔", description:"楽に単位が取れます")}
      let(:professor_image) {FactoryBot.create(:professor, image:File.new("#{Rails.root}/spec/fixtures/files/test_image.png"))}
      it "詳細ページに教授名と説明文が表示される" do
      #教授詳細ページに移動する
      visit professor_path(professor)
      #教授詳細ページに教授名と説明文が表示されるか確認する
      expect(page).to have_content "末柄真翔"
      expect(page).to have_content "楽に単位が取れます"
      end
      it "詳細ページに画像が表示される" do
      #教授詳細ページに移動する
      visit professor_path(professor_image)
      #教授詳細ページに画像が表示されるか確認する
      expect(page).to have_selector "img[src*='test_image.png']"
      end
    end
    # 教授レビューを編集できる
    describe "教授レビューの編集" do
      #テストデータを事前に用意する(imageなし)
      let(:professor) {FactoryBot.create(:professor, title:"末柄真翔", description:"楽に単位が取れます")}
      #テストデータを事前に用意する(imageあり)
      let(:professor_image) {FactoryBot.create(:professor, image:File.new("#{Rails.root}/spec/fixtures/files/test_image.png"))}
      
      context "titleを書き換えるとき" do
        it "titleを編集することができる" do
          #教授詳細ページに移動する
          visit professor_path(professor)
          #編集をするをクリックする(編集画面に遷移する)
          click_on "編集", exact:true
          #titleを書き換える
          fill_in "title", with: "すえがらまさと"
          #Update Professorをクリックする
          click_on "Update Professor"
          #編集ができたか確認する
          expect(page).to have_content "すえがらまさと"
        end
      end
      context "descripitonを書き換えるとき" do
        it "descriptionを編集することができる" do
          #教授詳細ページに移動する
          visit professor_path(professor)
          #編集をするをクリックする(編集画面に遷移する)
          click_on "編集", exact:true
          #descriptionを書き換える
          fill_in "description", with: "テストが難しいです"
          #Update Professorをクリックする
          click_on "Update Professor"
          #編集ができたか確認する
          expect(page).to have_content "テストが難しいです"
        end
      end
      context "imageを変更するとき" do
        it "imageを変更することができる" do
          #教授詳細ページに移動する
          visit professor_path(professor_image)
          #編集をするをクリックする(編集画面に遷移する)
          click_on "編集"
          #imageを変更する
          image_path= Rails.root.join('spec/fixtures/files/test_image2.png')
          attach_file("professor[image]", image_path, make_visible: true)
          #Update Professorをクリックする
          click_on "Update Professor"
          #編集ができたか確認する
          expect(page).to have_selector "img[src*=test_image2.png]"
        end
      end
    end
    # 教授レビューを削除できる
    describe "教授レビューの削除" do
      #データを事前に用意する
      let(:professor) {FactoryBot.create(:professor, title:"末柄真翔", description:"楽に単位が取れます")}
      it "教授レビューを削除することができる" do
        #教授詳細ページに移動する
        visit professor_path(professor)
        #削除ボタンをクリックする
        click_on "削除"
        #削除したことを確認する
        expect(page).not_to have_content "末柄真翔"
      end
    end
end
    