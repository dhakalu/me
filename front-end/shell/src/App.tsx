import React from "react";
import logo from "./logo.png";
import { AppWrapper } from "./AppWrapper";

function App() {
  return (
    <AppWrapper>
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p className="welcome">Welcome to my website!</p>
        <p>👷 This website is under construction. 👷</p>
      </header>
    </AppWrapper>
  );
}

export default App;
