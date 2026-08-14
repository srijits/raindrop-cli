def matches($pattern): .text | test($pattern; "i");

map(
  .text = ([.title, .excerpt, .domain, .link] | map(. // "") | join(" "))
  | .source_tags = (
      if (.domain | test("(^|\\.)x\\.com$|(^|\\.)twitter\\.com$"; "i")) then ["social", "post"]
      elif (.domain | test("(^|\\.)github\\.com$"; "i")) then ["dev", "code"]
      elif (.domain | test("(^|\\.)clawhub\\.ai$"; "i")) then ["openclaw", "skill"]
      elif (.domain | test("(^|\\.)youtube\\.com$|(^|\\.)youtu\\.be$"; "i")) then ["video", "media"]
      elif (.domain | test("(^|\\.)reddit\\.com$"; "i")) then ["social", "community"]
      elif (.domain | test("(^|\\.)docs\\.|documentation"; "i")) then ["docs", "reference"]
      else ["reading"]
      end
    )
  | .topic_tags = (
      []
      + (if matches("openclaw|clawhub|deployclaw") then ["openclaw", "agent"] else [] end)
      + (if matches("\\bagent(ic|s)?\\b|multi-agent|superagent|\\bmcp\\b") then ["ai", "agent"] else [] end)
      + (if matches("\\bllm(s)?\\b|language model|\\bgpt[- ]?[0-9]|claude|gemini|inference|quantiz") then ["ai", "ml", "models"] else [] end)
      + (if matches("prompt|context window|token[- ]?(saving|compress|efficien)") then ["ai", "prompts", "optimization"] else [] end)
      + (if matches("memory|knowledge graph|\\brag\\b|retrieval augmented") then ["memory"] else [] end)
      + (if matches("automation|workflow|browser use|browser automation|orchestrat") then ["automation"] else [] end)
      + (if matches("cyber|security|vulnerab|malware|threat") then ["security"] else [] end)
      + (if matches("\\bosint\\b|open.source intelligence") then ["osint", "research"] else [] end)
      + (if matches("\\bseo\\b|search engine optimization") then ["seo", "marketing"] else [] end)
      + (if matches("marketing|advertis|\\bads?\\b|analytics") then ["marketing"] else [] end)
      + (if matches("video|youtube|thumbnail") then ["video", "media"] else [] end)
      + (if matches("voice|audio|\\btts\\b|text.to.speech|speech") then ["audio", "ai"] else [] end)
      + (if matches("sarvam|bhashini|indian language|multilingual") then ["sarvam", "indian-languages", "ai"] else [] end)
      + (if matches("infrastructure|self.host|server|deploy|docker|kubernetes|cloudflare|observability|monitoring|gmail setup") then ["infrastructure"] else [] end)
      + (if matches("\\binvest(ment|ing|or|ors)?\\b|\\bfunding\\b|\\bfinance\\b|stock market|venture capital") then ["investment"] else [] end)
      + (if matches("research|paper|arxiv|study") then ["research"] else [] end)
      + (if matches("productivity|note.taking|personal knowledge") then ["productivity"] else [] end)
    )
  | .tags = ((.source_tags + .topic_tags) | unique)
  | .target_collection_id = (
      if .collection_id != -1 then null
      elif matches("openclaw|clawhub|deployclaw") then 67123668
      elif matches("sarvam|bhashini|indian language") then 67123669
      elif matches("\\bseo\\b|search engine optimization") then 67123671
      elif matches("infrastructure|gmail setup|docker|kubernetes|cloudflare|observability|monitoring") then 67123672
      elif matches("\\binvest(ment|ing|or|ors)?\\b|\\bfunding\\b|\\bfinance\\b|stock market|venture capital") then 67123673
      elif matches("model optimization|inference cost|token cost|quantiz|llm routing") then 67123670
      else null
      end
    )
  | {id, before_tags: .tags_existing, add_tags: .tags, before_collection_id: .collection_id, target_collection_id}
)
