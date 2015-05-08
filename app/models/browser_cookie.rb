class BrowserCookie < ActiveRecord::Base
  belongs_to :target_page

  def set(capybara_context)
    # return if name.blank?
    Capybara.current_session.driver.browser.manage.delete_all_cookies
    Capybara.
      current_session.
      driver.
      browser.
      manage.
      add_cookie(
        name: "header_content",
        value: 'shared/header_content02'
      )
    capybara_context.visit(target_page.fullpath)
  end
end
