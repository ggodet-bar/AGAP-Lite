module Grapher

  def self.identify_complete_subgraphs(edge_set)
    raise ArgumentError unless edge_set.instance_of?(Array) && \
                               edge_set.all?{|el| el.instance_of?(Array) && el.size == 2}
    rec_partition_edges([], edge_set)
  end

  def self.treeify_complete_graph(graph)
    rec_treeify_complete_graph(nil, graph)
  end

  def self.rec_treeify_complete_graph(current_branch, remaining_edges)
    if remaining_edges.empty?
      current_branch
    else
      current_edge = remaining_edges.shift
      if current_branch.nil?
        rec_treeify_complete_graph({:node => current_edge[0], :children => [current_edge[1]]}, remaining_edges)
      elsif current_branch[:node] == current_edge[0]
        current_branch[:children] = current_branch[:children] << current_edge[1]
        rec_treeify_complete_graph(current_branch, remaining_edges)
      elsif current_edge[1] == current_branch[:node]
        rec_treeify_complete_graph({:node => current_edge[0], :children => [current_branch]}, remaining_edges)
      else
        is_edge_inserted = false
        current_branch[:children] = current_branch[:children].collect do |child|
          if child == current_edge[0]
            child = {:node => child, :children => [current_edge[1]]}
            is_edge_inserted = true 
          elsif child.is_a?(Hash) && child.has_key?(:children)
            if child[:node] == current_edge[0]
              child[:children] = child[:children] << current_edge[1]
              is_edge_inserted = true
            elsif child[:children].any?{|c| (c.is_a?(Hash) && (c[:children].include?(current_edge[0]) || c[:node] == current_edge[0])) || c == current_edge[0]}
              rec_treeify_complete_graph(child, [current_edge])
              is_edge_inserted = true
            end
          end
          # In any other case, child should not be changed
          child
        end
        unless is_edge_inserted
          remaining_edges << current_edge
        end
        rec_treeify_complete_graph(current_branch, remaining_edges)
      end 
    end
  end

  # Partitions the remaining_edges into an array of complete oriented
  # subgraphs.
  #
  # current_partition - An Array of Arrays of edges (Array) that form
  #                     complete subgraphs
  # remaining_edges   - An Array of edges (Array)
  #
  # Returns the current_partition, whenever the remaining_edges array
  #   is empty.
  #
  def self.rec_partition_edges(current_partition, remaining_edges)
    if remaining_edges.empty?
      current_partition
    else
      current_edge = remaining_edges.shift
      found_assoc = false
      current_partition.each do |sub_partition|
        sub_partition.each do |edge_set|
          if !found_assoc &&
             edge_set[0] == current_edge[0] ||
             edge_set[1] == current_edge[0] ||
             edge_set[0] == current_edge[1]
            sub_partition << current_edge
            found_assoc = true
          end
        end
      end
      unless found_assoc
        current_partition << [current_edge]
      end
      rec_partition_edges(current_partition, remaining_edges)
    end
  end



end
