/@  openai-rpc-req-get-models,
    openai-rpc-req-list-assistants,
    openai-rpc-req-create-thread,
    openai-rpc-req-retrieve-thread,
    openai-rpc-req-delete-thread,
    openai-rpc-req-create-message,
    openai-rpc-req-list-messages,
    openai-rpc-req-retrieve-message,
    openai-rpc-req-create-run,
    openai-rpc-req-list-runs,
    openai-rpc-req-list-run-steps,
    openai-rpc-req-retrieve-run,
    openai-rpc-req-retrieve-run-step,
    openai-rpc-req-submit-tool-output
/-  *openai
::
|%
::
++  get-models
  |%
  +$  req  openai-rpc-req-get-models
  +$  res  json
  ++  dek
    =,  dejs:format
    |=  =json
    json
  ++  api  |=([=conf =req] (api-get conf /'models'))
  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  assistants
::
++  list-assistants
  |%
  +$  req  openai-rpc-req-list-assistants
  +$  res  (list assistant)
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format assistant:dejs) ~)
    +.result
  ++  api  |=([=conf =req] (api-get conf /assistants))
  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  threads
::
++  create-thread
  |%
  +$  message
    $:  role=@t
        content=@t
        file-ids=(list @t)
    ==
  +$  req  openai-rpc-req-create-thread
  +$  res  thread
  ++  enk
    |=  =req
    %+  frond:enjs:format  %messages
    :-  %a
    %+  turn  messages.req
    |=  =message
    ^-  json
    %-  pairs:enjs:format
    :~  role+s+role.message
        content+s+content.message
    ==
  ++  dek  thread:dejs
  ++  api  |=([=conf =req] (api-post conf /threads (enk req)))
  --
::
++  retrieve-thread
  |%
  +$  req  openai-rpc-req-retrieve-thread
  +$  res  thread
  ++  dek  thread:dejs
  ++  api  |=([=conf =req] (api-get conf /threads/[thread-id.req]))
  --
::
++  delete-thread
  |%
  +$  req  openai-rpc-req-delete-thread
  +$  res
    $:  thread-id=@t
        object=@t
        deleted=?
    ==
  ++  dek
    =,  dejs:format
    (ot id+so object+so deleted+bo ~)
  ++  api  |=([=conf =req] (api-delete conf /threads/[thread-id.req]))
  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  messages
::
++  create-message
  |%
  +$  req  openai-rpc-req-create-message
  +$  res  message
  ++  enk
    |=  =req
    =,  enjs:format
    %-  pairs
    :~  role+s+role.req
        content+s+content.req
::        [%'file_ids' a+(turn file-ids.req |=(i=@t s+i))]
    ==
  ++  dek  message:dejs
  ++  api
    |=  [=conf =req]
    (api-post conf /threads/[thread-id.req]/messages (enk req))
  --
::
++  list-messages
  |%
  +$  req  openai-rpc-req-list-messages
  +$  res  (list message)
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format message:dejs) ~)
    +.result
  ++  api
    |=  [=conf =req]
    (api-get conf /threads/[thread-id.req]/messages)
  --
::
++  retrieve-message
  |%
  +$  req  openai-rpc-req-retrieve-message
  +$  res  message
  ++  dek  message:dejs
  ++  api
    |=  [=conf =req]
    (api-get conf /threads/[thread-id.req]/messages/[message-id.req])
  --
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::  runs
::
++  create-run
  |%
  +$  req  openai-rpc-req-create-run
  ::       model=(unit @t)
  ::       instructions=(unit @t)
  ::       tools=~   :: todo, should we bother with per-run tools?
  +$  res  ^run
  ++  enk
    |=  =req
    =,  enjs:format
    %-  pairs
    :~  %'assistant_id'^s+assistant-id.req
    ==
  ++  dek  run:dejs
  ++  api  |=([=conf =req] (api-post conf /threads/[thread-id.req]/runs (enk req)))
  --
::
++  list-runs
  |%
  +$  req  openai-rpc-req-list-runs
  +$  res  (list ^run)
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format run:dejs) ~)
    +.result
  ++  api  |=([=conf =req] (api-get conf /threads/[thread-id.req]/runs))
  --
::
++  list-run-steps
  |%
  +$  req  openai-rpc-req-list-run-steps
  +$  res  (list run-step)
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format run-step:dejs) ~)
    +.result
  ++  api  |=([=conf =req] (api-get conf /threads/[thread-id.req]/runs/[run-id.req]/steps))
  --
::
++  retrieve-run
  |%
  +$  req  openai-rpc-req-retrieve-run
  +$  res  ^run
  ++  dek  run:dejs
  ++  api  |=([=conf =req] (api-get conf /threads/[thread-id.req]/runs/[run-id.req]))
  --
::
++  retrieve-run-step
  |%
  +$  req  openai-rpc-req-retrieve-run-step
  +$  res  run-step
  ++  dek  run-step:dejs
  ++  api  |=([=conf =req] (api-get conf /threads/[thread-id.req]/runs/[run-id.req]/steps/[step-id.req]))
  --
::
++  submit-tool-output
  |%
  +$  req  openai-rpc-req-submit-tool-output
  +$  res  ^run
  ++  enk
    |=  =req
    =,  enjs:format
    %+  frond  %'tool_outputs'
    :-  %a
    [(pairs %'tool_call_id'^s+call-id.req output+s+output.req ~) ~]
  ++  dek  run:dejs
  ++  api  |=([=conf =req] (api-post conf /threads/[thread-id.req]/runs/[run-id.req]/'submit_tool_outputs' (enk req)))
  --
--
