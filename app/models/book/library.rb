#coding: utf-8
class Book::Library < Book

  after_initialize :set_first_attr

  def set_first_attr
    self.title = 'ライブラリ'
  end

end
