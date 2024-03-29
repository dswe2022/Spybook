function Footer({user}) {
  // if no user is logged in
  if (!user) {
    return (
      <footer className='footer-logged-out'>
        <small className='footer-language'>
          English (US)
        </small>
        <div>
          <small className='footer-copy-logged-out'>
            Lookbook &copy; 2022
          </small>
          <ul className='footer-links-logged-out'>
            <li><a href='https://github.com/dsmart2080/Spybook' target='_blank'>GitHub</a></li>
            <li><a href='https://www.linkedin.com/in/dave-s-716ab841/' target='_blank'>LinkedIn</a></li>
            
          </ul>
        </div>
        <small className='footer-tech-stack'>
          Spybook is a clone of Facebook built using Ruby, Rails, JavaScript, React, HTML, and CSS. 
          Check out its <a href='https://github.com/dsmart2080/Spybook' target='_blank'>source code on my GitHub</a>!
        </small>
      </footer>
    );
  }

  // if an user is logged in
  return (
    <footer className='footer'>
      <small className='footer-copy'>
        Spybook &copy; 2022
      </small>
      <ul className='footer-links'>
        <li><a href='https://github.com/dsmart2080/Spybook' target='_blank'>GitHub</a></li>
        <li><a href='' target='_blank'>LinkedIn</a></li>
        <li><a href='' target='_blank'>Medium</a></li>
      </ul>
    </footer>
  );
}

export default Footer;