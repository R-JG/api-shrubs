/-  aether
|_  state=state-0:aether
++  enjs
  =,  enjs:format
  |=  act=action:aether
  |^  ^-  json
  ?+  -.act  ~|("Unknown request type" !!)
    %populate-tx         (populate-tx +.act)
    %view                (view +.act)
    :: %get-block-info   (get-block-info +.act)
    :: %get-tx-info      (get-by-tx +.act)
    :: %get-block-by-tx  (get-by-tx +.act)
    :: %get-tx-height    (get-by-tx +.act)
  ==
  ++  populate-tx
    |=  [from=@t to=@t value=@ data=@t]
    ^-  json
    %-  pairs
    :~  ['to' [%s (crip (skip (trip to) |=(c=@t =(c '.'))))]]
        ['from' [%s (crip (skip (trip from) |=(c=@t =(c '.'))))]]
        ['value' (numb value)]
        ['data' [%s data]]
    ==
  ::
  ++  view
    |=  [from=@t to=@t data=@t]
    ^-  json
    %-  pairs
    :~  ['to' [%s (crip (skip (trip to) |=(c=@t =(c '.'))))]]
        ['from' [%s (crip (skip (trip from) |=(c=@t =(c '.'))))]]
        ['data' [%s data]]
    ==
  :: ++  get-block-info
  ::   |=  height=(unit @)
  ::   ^-  json
  ::   =/  ht=@
  ::     ?:  =(^ height)  u.height
  ::     ?:  =(^ height.state)  u.height.state
      
  ::   %-  pairs
  ::   ~[['height' (numb height)]]
  :: ::
  :: ++  get-by-tx
  ::   |=  hash=@t
  ::   ^-  json
  ::   %-  pairs
  ::   ~[['hash' [%s hash]]]
  --
::
++  action-to-request
  |=  act=action:aether
  |^  ^-  request:http
  ?+    -.act  !!
      %history
    %-  get-request
    %+  url  '/get-history/'  (crip (skip (scow %ux addr.act) |=(c=@t =(c '.'))))
  ::
      %balance
    %-  get-request
    %+  url  '/get-balance/'  (crip (skip (scow %ux addr.act) |=(c=@t =(c '.'))))
  ::
      %ping
    %-  get-request
    %+  url  '/height'  ''
  ::
      %get-height
    %-  get-request
    %+  url  '/height'  ''
  ::
      %get-fee
    %-  get-request
    %+  url  '/fee'  ''
  ::
      %get-block-info
    %-  get-request
    %+  url  '/block-info'
    ?:  ?=([~ u=@] height.act)
      u.height.act
    ?:  ?=([~ u=@] height.state)
      u.height.state
    !!
  ::
      %get-tx-info
    %-  get-request
    %+  url  '/tx-info'  hash.act
  ::
      %get-block-by-tx
    %-  get-request
    %+  url  '/block-by-tx'  hash.act
  ::
      %get-tx-height
    %-  get-request
    %+  url  '/tx-height'  hash.act
  ::
      %populate-tx
    %-  post-request
    :-  %+  url  '/populate-tx'  ''  act
  ::
      %view
    %-  post-request
    :-  %+  url  '/call-getter'  ''  act
  ::
      %send-tx
    %-  get-request
    %+  url  '/send-tx/'
    %^  cat  3  '0x0'
    %+  rsh  [3 2]
    (crip (skip (scow %ux tx.act) |=(c=@t =(c '.'))))
  ==
  ::
  ++  url
  |=  [route=@t params=@t]
  %^    cat
      3
    (cat 3 proxy-url.state route)
  params
  ::
  ++  get-request
    |=  url=@t
    ^-  request:http
    [%'GET' url ~ ~]
  ::
  ++  post-request
    |=  [url=@t act=action:aether]
    ^-  request:http
    :*  %'POST'
        url
        ['Content-Type' 'application/json']~
        =,  html
        %-  some
        %-  as-octt:mimes
        %-  trip
        %-  en:json
        (enjs act)
    ==
  --
::
++  dejs
  =,  dejs:format
  |%
  ++  response
    |=  [act=action:aether jon=json]
    |^  ^-  response:aether
    ?+    -.act  !!
        %history
      :-  %history
      %+  roll  ((ar history-item) jon)
      |=  [h=history-item:aether out=(map @ux history-item:aether)]
      (~(put by out) `@ux`(sham h) h)
    ::
        %balance
      :-  %balance
      ~|  jon
      %.  jon  (ot balance+(om (su dem)) ~)
    ::
        %ping
      :-  %get-height
      %.  jon  (ot ['height' ni]^~)
    ::
        %get-height
      :-  %get-height
      %.  jon  (ot ['height' ni]^~)
    ::
        %get-fee
      :-  %get-fee
      ^-  fees:aether
      %.  jon  (ot ~[['base' ni] ['priority' ni]])
    ::
        %get-block-by-tx
      [%get-block-by-tx (block-info jon)]
    ::
        %get-block-info
      [%get-block-info (block-info jon)]
    ::
        %get-tx-info
      [%get-tx-info (tx-info jon)]
    ::
        %get-tx-height
      :-  %get-tx-height
      %.  jon  (ot ~[['hash' so] ['height' ni]])
    ::
        %send-tx
      [%send-tx ((ot success+bo ~) jon)]
    ::
        %populate-tx
      [%populate-tx ((ot ~[gas+ni network+so nonce+ni]) jon)]
    ::
        %view
      [%view ((ot data+so ~) jon)]
    ==
    ::
    ++  history-item
      ^-  $-(json history-item:aether)
      %-  ot
      :~  asset+so
          'blockNum'^(su ;~(pfix (jest '0x') hex))
          hash+(su ;~(pfix (jest '0x') hex))
          from+(su ;~(pfix (jest '0x') hex))
          to+(su ;~(pfix (jest '0x') hex))
          value+ne
          timestamp+so
      ==
    ::
    ++  block-info
      |=  jon=json
      ^-  block-info:aether
      %.  jon  %-  ot
      :~  ['height' ni]
          ['hash' so]
          ['miner' so]
          ['gas' ni]
          ['txs' (ar so)]
      ==
    ::
    ++  tx-info
      |=  jon=json
      ^-  tx-info:aether
      %.  jon  %-  ot
      :~  ['hash' so]
          ['height' ni]
          ['to' so]
          ['from' so]
          ['value' ni]
          ['gas' ni]
          ['data' so]
          ['index' ni]
      ==
    --
  --
::
++  status-code
  |=  =client-response:iris
  ^-  @ud
  ?>  ?=(%finished -.client-response)
  status-code.response-header.client-response
::
++  handle-response  :: previously ++send
  |=  [act=action:aether res=client-response:iris]
  ^-  response:aether
  =/  status=@ud  (status-code res)
  =/  body=@t
    ?>  ?=(%finished -.res)
    ?~  full-file.res  ''
    q.data.u.full-file.res
  =/  jon=(unit json)  (de:json:html body)
  ?~  jon
    ~&  "de:json:html failed"
    ~&  body
    !!
  ?.  =(status 200)
    [%err ~]
  (response:dejs act u.jon)
::
--
