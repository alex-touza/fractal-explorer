/*#let header = context () => {

  let get_header = () => {
    let selector = selector(heading.where(level: 1)).before(here());
  
    let elements = query(selector);

    let current_page = here().page()
  
    if elements.len() > 0 {
      let el = elements.last();

      let heading_page = counter(page).at(el.location())
      
      if el.body.text != outline.title.text {
        return el.body;
      }
    }

    return false;
  }

  let number = counter(heading).at(here()).first();
  let header = get_header()

  if header == false {
    return
  }

  set text(weight: "bold");
  h(1fr)
  [Capítol #number. ]
  header
  
}*/