module Orderable
  extend ActiveSupport::Concern

  class_methods do
    def orderable(scope_column_name)
      @@orderable_class = self
      @@orderable_scope_column_name = scope_column_name
      around_save :orderable_update_order_on_update!, if: Proc.new { |resource| resource.order_changed? }
      after_destroy :orderable_update_order_on_destroy!
    end
  end

  def orderable_update_order_on_update!
    prev_order = order_was
    yield
    resources_without_updated = @@orderable_class
      .where("#{@@orderable_scope_column_name}": self.send(@@orderable_scope_column_name))
      .sort_by(&:order).select {|resource| resource != self }
    return if resources_without_updated.empty?

    new_index = resources_without_updated.index {|resource| resource.order == order}
    return if new_index.nil?

    old_index = prev_order ? resources_without_updated.index {|resource| resource.order > prev_order} : nil
    if !prev_order || prev_order > order
      old_index = resources_without_updated.length if old_index.nil?
      ids_to_update = resources_without_updated.slice(new_index...old_index).map(&:id)
      @@orderable_class
        .where(id: ids_to_update)
        .update_all(%Q{"order" = #{self.class.table_name}."order" + 1})
    elsif prev_order < order
      old_index = 0 if old_index.nil?
      ids_to_update = resources_without_updated.slice(old_index..new_index).map(&:id)
      @@orderable_class
        .where(id: ids_to_update)
        .update_all(%Q{"order" = #{self.class.table_name}."order" - 1})
    end
  end

  def orderable_update_order_on_destroy!
    resources = @@orderable_class
      .where("#{@@orderable_scope_column_name}": self.send(@@orderable_scope_column_name))
      .sort_by(&:order)

    old_index = resources.index {|resource| resource.order > order}
    return if old_index.nil?
    ids_to_update = resources.slice(old_index...resources.length).map(&:id)

    @@orderable_class
      .where(id: ids_to_update)
      .update_all(%Q{"order" = #{self.class.table_name}."order" - 1})
  end
end
