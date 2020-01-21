module Orderable
  extend ActiveSupport::Concern

  class_methods do
    def orderable(scope_column_name)
      @@orderable_scope_column_name = scope_column_name
      around_save :orderable_update_order!, if: Proc.new { |resource| resource.order_changed? }
    end
  end

  def orderable_update_order!
    prev_order = order_was
    yield
    flow_resources_without_updated = self.class
      .where("#{@@orderable_scope_column_name}": self.send(@@orderable_scope_column_name))
      .sort_by(&:order).select {|resource| resource != self }
    return if flow_resources_without_updated.empty?

    new_index = flow_resources_without_updated.index {|resource| resource.order == order}
    return if new_index.nil?

    old_index = prev_order ? flow_resources_without_updated.index {|resource| resource.order > prev_order} : nil

    if !prev_order || prev_order > order
      old_index = flow_resources_without_updated.length if old_index.nil?
      ids_to_update = flow_resources_without_updated.slice(new_index...old_index).map(&:id)
      self.class
        .where(id: ids_to_update)
        .update_all(%Q{"order" = #{self.class.table_name}."order" + 1})
    elsif prev_order < order
      old_index = 0 if old_index.nil?
      ids_to_update = flow_resources_without_updated.slice(old_index..new_index).map(&:id)
      self.class
        .where(id: ids_to_update)
        .update_all(%Q{"order" = #{self.class.table_name}."order" - 1})
    end
  end
end
