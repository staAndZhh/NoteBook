# python

### jupyter 不弹出浏览器

1. jupyter notebook --generate-config	

2. 找到jupyter_notebook_config.py

3. 修改#c.NotebookApp.browser = ''

4. 修改为：

   import webbrowser

   webbrowser.register("Chrome", None, webbrowser.GenericBrowser(u"C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"))
   c.NotebookApp.browser = u'Chrome'