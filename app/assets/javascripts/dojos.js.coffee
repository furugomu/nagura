localStorageGetItem = (key, defaultValue=null) ->
  json = localStorage.getItem(key)
  if json
    JSON.parse(json)
  else
    defaultValue

localStorageSetItem = (key, value) ->
  localStorage.setItem(key, JSON.stringify(value))

KEY = 'counts'
load = -> localStorageGetItem(KEY, {})
save = (value) -> localStorageSetItem(KEY, value)

show = (id, count) ->
  $('#count'+id).text(count)

jQuery ($) ->
  if not window.localStorage
    return

  # 初期表示
  for id, count of load()
    show(id, count)

  # 殴りに行ったら数を増やす
  $('.visit').click (e) ->
    counts = load()
    id = $(this).data('id')
    counts[id] ||= 0
    counts[id] += 1
    save(counts)
    show(id, counts[id])

  # リセットボタン
  $("#reset-button-placeholder").append(
    $("<button>殴り回数リセット</button>").click (e)->
      save({})
      $(".count").text(''))
