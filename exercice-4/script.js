function gotoTitle(id) {
  if (id !== '' ) {
    document.getElementById('iframe').src= url + '#' + id ;
  } else {
    alert('Impossible de se rendre à cette entrée de table des matière')
  }
}