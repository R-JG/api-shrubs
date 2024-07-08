/@  coingecko-rpc-input
/@  coingecko-rpc-output
/-  constants
=<
^-  kook:neo
|%
++  state  [%or pro/%coingecko-rpc-input pro/%coingecko-rpc-output ~]
++  poke   (sy %iris-res ~)
++  kids   *kids:neo
++  deps   *deps:neo
++  form
  ^-  form:neo
  |_  [=bowl:neo =aeon:neo =pail:neo]
  ++  init
    |=  pal=(unit pail:neo)
    ^-  (quip card:neo pail:neo)
    ?>  &(?=(^ pal) ?=(%coingecko-rpc-input p.u.pal))
    =/  inp
      !<(coingecko-rpc-input q.u.pal)
    =/  cof=conf
      [coingecko-key.constants coingecko-base-url.constants]
    =;  req=ireq
      ~&  >>  coingecko-request/req
      :_  u.pal
      :~  [#/[p/our.bowl]/$/iris %poke iris-req/!>(req)]
      ==
    ?-  -.inp
      %ping   (api:ping cof inp)
      %price  (api:price cof inp)
    ==
  ::
  ++  poke
    |=  [=stud:neo vaz=vase]
    ^-  (quip card:neo pail:neo)
    ?+  stud  [~ pail]
        %iris-res
      ?>  ?=(%coingecko-rpc-input p.pail)
      =/  state
        !<(coingecko-rpc-input q.pail)
      =/  res
        !<(ires vaz)
      =;  out=coingecko-rpc-output
        ~&  >  coingecko-rpc-output/out
        [~ coingecko-rpc-output/!>(out)]
      ?-  -.state
        %ping   [-.state (dek:ping (extra dat.res))]
        %price  [-.state (dek:price (extra dat.res))]
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
::
:: :: neo %iris-req poke
+$  ireq  [hand=pith:neo dat=request:http]
:: :: neo %iris-res poke
+$  ires  [hand=pith:neo dat=client-response:iris]
::
+$  req  coingecko-rpc-input
::
+$  res  coingecko-rpc-output
::
++  extra
  |=  dat=client-response:iris
  ^-  json
  =/  cod=cord
    ?>  ?=(%finished -.dat)
    ?~  full-file.dat  ''
    q.data.u.full-file.dat
  =/  jon  (de:json:html cod)
  ?~  jon  ~&(>>> [%body-is-not-json cod] !!)
  ~|  json+u.jon
  u.jon
::
++  headers
  |=  =conf
  ^-  (list (pair @t @t))
  :~  :-  'Content-type'   'application/json'
      :-  'Accept'         'application/json'
      :-  'x-cg-api-key'   key.conf
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
::
++  ping
  |%
  ++  dek
    =,  dejs:format
    |=  =json
    json
  ++  api  |=([=conf =req] (api-get conf /'ping'))
  --
::
++  price
  |%
  ++  dek
    =,  dejs:format
    |=  =json
    =/  obj=(map @t (map @t @))  ((om (om ne)) json)
    ?~  obj  !!
    ?~  q.n.obj  !!
    [[cryp=p.n.obj fiat=p.n.q.n.obj] price=q.n.q.n.obj]
  ::
  ++  params
    |=  =req
    ^-  path
    ?>  ?=(%price -.req)
    =/  with-query
      %+  rap  3
        :~  'price?vs_currencies='
            fiat.req.req
            '&ids='
            cryp.req.req
        ==
    /'simple'/[with-query]
  ++  api  |=([=conf =req] (api-get conf (params req)))
  --
::
:: ++  coins
::   |%
::   +$  req  ~
::   +$  res  json
::   ++  dek
::     =,  dejs:format
::     |=  =json
::     json
::   ++  api  |=([=conf =req] (api-get conf /'coins'/'list'))
::   --
:: ::
:: ++  coin-data
::   |%
::   +$  req  id=@t
::   +$  res  json
::   ++  dek
::     =,  dejs:format
::     |=  =json
::     json
::   ++  api  |=([=conf =req] (api-get conf /'coins'/(scot %uv req)))
::   --
--
