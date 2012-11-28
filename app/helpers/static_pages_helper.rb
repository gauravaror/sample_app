module StaticPagesHelper

  def feed
    Micropost.where('user_id = ?',id);
  end
end
