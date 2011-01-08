module LootHelper
  # Given a reason string, look for any WoW item code
  # and turn it into a link to wowhead
  def parse_item(text)
    item_id = text.match(/Hitem:(\d+):/)
    item_name = text.match(/(\[.*\])/)

    if item_id && item_name
      link = link_to(item_name[1], "http://www.wowhead.com/?item=#{item_id[1]}", :class => "epic")
      text.gsub(/\|c.*\|r/, link)
    else
      text
    end
  end
end
