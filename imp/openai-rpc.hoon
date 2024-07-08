/@  openai-rpc-input
/@  openai-rpc-output
/-  constants
/-  openai
=,  openai
=<
^-  kook:neo
|%
++  state  [%or pro/%openai-rpc-input pro/%openai-rpc-output ~]
++  poke   (sy %iris-res ~)
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    ?>  &(?=(^ pal) ?=(%openai-rpc-input p.u.pal))
    =/  inp
      !<(openai-rpc-input q.u.pal)
    =/  cof=conf
      [openai-key.constants openai-base-url.constants]
    =;  req=ireq
      ~&  >>  openai-request/req
      :_  u.pal
      :~  [#/[p/our.bowl]/$/iris %poke iris-req/!>(req)]
      ==
    ?-  -.inp
      %get-models          (api:get-models cof inp)
      %list-assistants     (api:list-assistants cof inp)
      %create-thread       (api:create-thread cof inp)
      %retrieve-thread     (api:retrieve-thread cof inp)
      %delete-thread       (api:delete-thread cof inp)
      %create-message      (api:create-message cof inp)
      %list-messages       (api:list-messages cof inp)
      %retrieve-message    (api:retrieve-message cof inp)
      %create-run          (api:create-run cof inp)
      %list-runs           (api:list-runs cof inp)
      %list-run-steps      (api:list-run-steps cof inp)
      %retrieve-run        (api:retrieve-run cof inp)
      %retrieve-run-step   (api:retrieve-run-step cof inp)
      %submit-tool-output  (api:submit-tool-output cof inp)
    ==
  ::
  ++  poke
    |=  [=stud:neo vaz=vase]
    ^-  (quip card:neo pail:neo)
    ?+  stud  [~ pail]
        %iris-res
      ?>  ?=(%openai-rpc-input p.pail)
      =/  state
        !<(openai-rpc-input q.pail)
      =/  res
        !<(ires vaz)
      =;  out=openai-rpc-output
        ~&  >  openai-rpc-output/out
        [~ openai-rpc-output/!>(out)]
      ?-  -.state
        %get-models          [-.state (dek:get-models (extra dat.res))]
        %list-assistants     [-.state (dek:list-assistants (extra dat.res))]
        %create-thread       [-.state (dek:create-thread (extra dat.res))]
        %retrieve-thread     [-.state (dek:retrieve-thread (extra dat.res))]
        %delete-thread       [-.state (dek:delete-thread (extra dat.res))]
        %create-message      [-.state (dek:create-message (extra dat.res))]
        %list-messages       [-.state (dek:list-messages (extra dat.res))]
        %retrieve-message    [-.state (dek:retrieve-message (extra dat.res))]
        %create-run          [-.state (dek:create-run (extra dat.res))]
        %list-runs           [-.state (dek:list-runs (extra dat.res))]
        %list-run-steps      [-.state (dek:list-run-steps (extra dat.res))]
        %retrieve-run        [-.state (dek:retrieve-run (extra dat.res))]
        %retrieve-run-step   [-.state (dek:retrieve-run-step (extra dat.res))]
        %submit-tool-output  [-.state (dek:submit-tool-output (extra dat.res))]
      ==
    ==
  --
--
::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::
|%
::
+$  conf  [key=@t url=@t]
::
++  any  |=(j=json j)
:: :: neo %iris-req poke
+$  ireq  [hand=pith:neo dat=request:http]
:: :: neo %iris-res poke
+$  ires  [hand=pith:neo dat=client-response:iris]
::
+$  req  openai-rpc-input
::
+$  res  openai-rpc-output
::
++  extra
  |=  dat=client-response:iris
  ^-  json
  =/  cod=cord
    ?>  ?=(%finished -.dat)
    ?~  full-file.dat  ''
    q.data.u.full-file.dat
  =/  jon  (de:json:html cod)
  ?~  jon  ~&(>>> [%body-is-not-json cord] !!)
  ~|  json+u.jon
  u.jon
::
++  headers
  |=  =conf
  ^-  (list (pair @t @t))
  :~  :-  'Content-type'   'application/json'
      :-  'Accept'         'application/json'
      :-  'Authorization'  (cat 3 'Bearer ' key.conf)
      :-  'OpenAI-Beta'    'assistants=v2'
  ==
::
++  api-raw
  |=  [=conf =method:http =path bod=(unit octs)]
  ^-  ireq
  =/  url  (cat 3 url.conf (spat path))
  =/  hed  (headers conf)
  [path [method url hed bod]]
::
++  api-call
  |=  [=conf =method:http =path body=json]
  (api-raw conf method path `(as-octs:mimes:html (en:json:html body)))
::
++  api-post
  |=  [=conf =path body=json]
  (api-raw conf %'POST' path `(as-octs:mimes:html (en:json:html body)))
::
++  api-delete
  |=  [=conf =path]
  (api-raw conf %'DELETE' path [~ *octs])
::
++  api-get
  |=  [=conf =path]
  (api-raw conf %'GET' path ~)
::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::
::  models
::
++  get-models
  |%
  ++  dek
    =,  dejs:format
    |=  =json
    json
  ++  api  |=([=conf =req] (api-get conf /'models'))
  --
::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::
::  assistants
::
++  list-assistants
  |%
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format assistant:dejs) ~)
    +.result
  ++  api  |=([=conf =req] (api-get conf /assistants))
  --
::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::
::  threads
::
++  create-thread
  |%
  +$  message
    $:  role=@t
        content=@t
        file-ids=(list @t)
    ==
  ++  enk
    |=  =req
    ?>  ?=(%create-thread -.req)
    %+  frond:enjs:format  %messages
    :-  %a
    %+  turn  messages.req.req
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
  ++  dek  thread:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%retrieve-thread -.req)
    (api-get conf /threads/[thread-id.req.req])
  --
::
++  delete-thread
  |%
  ++  dek
    =,  dejs:format
    (ot id+so object+so deleted+bo ~)
  ++  api
    |=  [=conf =req]
    ?>  ?=(%delete-thread -.req)
    (api-delete conf /threads/[thread-id.req.req])
  --
::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::
::  messages
::
++  create-message
  |%
  ++  enk
    |=  =req
    ?>  ?=(%create-message -.req)
    =,  enjs:format
    %-  pairs
    :~  role+s+role.req.req
        content+s+content.req.req
::        [%'file_ids' a+(turn file-ids.req |=(i=@t s+i))]
    ==
  ++  dek  message:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%create-message -.req)
    (api-post conf /threads/[thread-id.req.req]/messages (enk req))
  --
::
++  list-messages
  |%
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format message:dejs) ~)
    +.result
  ++  api
    |=  [=conf =req]
    ?>  ?=(%list-messages -.req)
    (api-get conf /threads/[thread-id.req.req]/messages)
  --
::
++  retrieve-message
  |%
  ++  dek  message:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%retrieve-message -.req)
    (api-get conf /threads/[thread-id.req.req]/messages/[message-id.req.req])
  --
::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::  ::
::  runs
::
++  create-run
  |%
  ++  enk
    |=  =req
    ?>  ?=(%create-run -.req)
    =,  enjs:format
    %-  pairs
    :~  %'assistant_id'^s+assistant-id.req.req
    ==
  ++  dek  run:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%create-run -.req)
    (api-post conf /threads/[thread-id.req.req]/runs (enk req))
  --
::
++  list-runs
  |%
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format run:dejs) ~)
    +.result
  ++  api
    |=  [=conf =req]
    ?>  ?=(%list-runs -.req)
    (api-get conf /threads/[thread-id.req.req]/runs)
  --
::
++  list-run-steps
  |%
  ++  dek
    |=  =json
    =/  result
      %.  json
      (ot:dejs:format object+so:dejs:format data+(ar:dejs:format run-step:dejs) ~)
    +.result
  ++  api
    |=  [=conf =req]
    ?>  ?=(%list-run-steps -.req)
    (api-get conf /threads/[thread-id.req.req]/runs/[run-id.req.req]/steps)
  --
::
++  retrieve-run
  |%
  ++  dek  run:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%retrieve-run -.req)
    (api-get conf /threads/[thread-id.req.req]/runs/[run-id.req.req])
  --
::
++  retrieve-run-step
  |%
  ++  dek  run-step:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%retrieve-run-step -.req)
    (api-get conf /threads/[thread-id.req.req]/runs/[run-id.req.req]/steps/[step-id.req.req])
  --
::
++  submit-tool-output
  |%
  ++  enk
    |=  =req
    ?>  ?=(%submit-tool-output -.req)
    =,  enjs:format
    %+  frond  %'tool_outputs'
    :-  %a
    [(pairs %'tool_call_id'^s+call-id.req.req output+s+output.req.req ~) ~]
  ++  dek  run:dejs
  ++  api
    |=  [=conf =req]
    ?>  ?=(%submit-tool-output -.req)
    (api-post conf /threads/[thread-id.req.req]/runs/[run-id.req.req]/'submit_tool_outputs' (enk req))
  --
--
