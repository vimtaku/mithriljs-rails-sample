# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(->


  Book = (data)->
    @name = m.prop(data.name || '')
    return this

  BookList = {
    vm: {
      searchText: m.prop('')
    }
    controller: ->
      vm = BookList.vm
      vm.entries = m.prop([])
      m.request({
        method: "GET",
        url: "/books.json",
        type: Book
      }).then((got) =>
        vm.entries(got)
      )
    view: (ctrl) ->
      vm = BookList.vm
      inputView = m('input', {
        oninput: m.withAttr("value", vm.searchText)
      }, value: vm.searchText())
      return [inputView,
        m('ul',
          vm.entries().filter((e) ->
            if vm.searchText() == ''
              return true
            e.name().match( vm.searchText() )
          ).map((e,i)->
            return m('li', e.name())
          )
        )
      ]
  }

  m.mount(document.getElementById('book-list'), BookList)
)
