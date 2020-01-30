module WordsHelper
  def next_review(word)
    if word.reviews.pending.count == 1
      'It should be reviewed today'
    elsif word.reviews.notperformed.count == 1
      'It may be reviewed in ' + pluralize((word.reviews.last.scheduled_for - Date.today).to_i, 'day')
    else
      'It may NOT be reviewed'
    end
  end
end
