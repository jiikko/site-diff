site = Site.create(name: 'google', url: 'http://search.yahoo.com')
site.target_pages.create(path: '/search')
site.target_pages.create(path: '/search;_ylt=A3xT6tTiLkdVbCsArmuJBtF7?p=%E3%83%B4%E3%82%A9%E5%A4%9A&search.x=1&fr=top_ga1_sa&tid=top_ga1_sa&ei=UTF-8&aq=&oq=&afs=')

site = Site.create(name: 'gigazine', url: 'https://duckduckgo.com')
site.target_pages.create(path: '/?q=java')
site.target_pages.create(path: '/?q=aaa')
site.target_pages.create(path: '/?q=uma')
