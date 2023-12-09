class AddIssueToNewsArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :news_articles, :issue, :string
  end
end
