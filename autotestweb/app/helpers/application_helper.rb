# :nodoc:
module ApplicationHelper
  def left_menu
    left_menu_entries(left_menu_content)
  end

  def env_list
    ENV_LIST
  end

  def casetype_list
    TESTCASE_TYPE
  end
  

  def scope_list
    SCOPE_LIST
  end

  private

  def left_menu_entries(entries = [])
    output = ""
    entries.each do |entry|
      children_selected = entry[:children] &&
                          entry[:children].any? { |child| current_page?(child[:href]) }
      entry_selected = current_page?(entry[:href])
      li_class =
        case
        when children_selected
          "open"
        when entry_selected
          "active"
        end
      output +=
        content_tag(:li, class: li_class) do
          subentry = ""
          subentry +=
            link_to entry[:href], title: entry[:title], class: entry[:class], target: entry[:target] do
              link_text = ""
              link_text += entry[:content].html_safe
              if entry[:children]
                if children_selected
                  link_text += '<b class="collapse-sign"><em class="fa fa-minus-square-o"></em></b>'
                else
                  link_text += '<b class="collapse-sign"><em class="fa fa-plus-square-o"></em></b>'
                end
              end

              link_text.html_safe
            end
          if entry[:children]
            if children_selected
              ul_style = "display: block"
            else
              ul_style = ""
            end
            subentry +=
              "<ul style='#{ul_style}'>" +
                left_menu_entries(entry[:children]) +
                "</ul>"
          end

          subentry.html_safe
        end
    end
    output.html_safe
  end

  def left_menu_content
    [
      {
        href: "/projects",
        #title: _("blank"),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "项目" + "</span>",
      },

      {
        href: "/apps",
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "应用" + "</span>",
      },
      {
        href: "/servers",
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "测试机器" + "</span>",
      },
      {
        href: proxies_path,
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "测试代理URL" + "</span>",
      },
      {
        href: "#",
        content: "<i class='fa fa-user-md'></i> <span class='menu-item-parent'>" + "测试用例" + "</span>",
        children: [
          {
            href: "/testcases?case_type=api",
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "API用例" + "</span>",
          },
          {
            href: "/testcases?case_type=web",
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "WEB用例" + "</span>",
          },
          {
            href: templates_path,
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "测试报告模板" + "</span>",
          },

          {
            href: run_testcase_logs_path,
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "测试结果" + "</span>",
          },
          {
            href: delaytasks_path,
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "定时计划" + "</span>",
          },

          {
            href: "#",
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "邮件管理" + "</span>",
            children: [
              {
                href: emails_path,
                content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "Email" + "</span>",
              },
              {
                href: emailgroups_path,
                content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "Email Group" + "</span>",
              },

            ],
          },

        ],
      },

      {
        href: "#",
        content: "<i class='fa fa-user-md'></i> <span class='menu-item-parent'>" + "配置文件" + "</span>",
        children: [
          {
            href: "/configs?env=beta",
            content: "<i class='fa fa-fw fa-folder-open'></i> <span class='menu-item-parent'>" + "beta" + "</span>",
          },

        ],
      },
      {
        href: "#",
        content: "<i class='fa fa-user-md'></i> <span class='menu-item-parent'>" + "日志" + "</span>",
        children: [
          {
            href: logs_path,
            content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "日志raw " + "</span>",
          },
          {
            href: optimizationindexs_path,
            content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "日志(优化)" + "</span>",
          },
          {
            href: constants_path,
            content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + "常量" + "</span>",
          },

        ],
      },
    ]
  end
end
