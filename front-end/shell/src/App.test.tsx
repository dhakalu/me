import React from "react";
import { render, screen } from "@testing-library/react";
import App from "./App";

describe("App", () => {
  it("should render welcome message", () => {
    render(<App />);
    const linkElement = screen.getByText(/welcome to my website!/i);
    expect(linkElement).toBeInTheDocument();
  });

  it("should render under construction message", () => {
    render(<App />);
    const linkElement = screen.getByText(
      /this website is under construction./i
    );
    expect(linkElement).toBeInTheDocument();
  });
});
