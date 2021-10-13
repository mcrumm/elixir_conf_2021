let Contenteditable = {
  mounted() {
    this.onBlur = this.onBlur.bind(this);
    this.code = this.el.querySelector("code");
    this.wasText = this.code.innerText;

    this.el.addEventListener("click", () => {
      this.code.setAttribute("contenteditable", "true");
      this.code.addEventListener("blur", this.onBlur);
      this.code.focus();
    });
  },
  updated() {
    if(this.wasText != this.code.innerText) {
      this.wasText = this.code.innerText;
    }
  },
  onBlur() {
    let nextText = this.code.innerText;
    this.code.setAttribute("contenteditable", "false");
    if(this.wasText != nextText) {
      this.wasText = nextText;
      this.pushEvent("contenteditable", { contents: this.code.innerText });
    }
    this.code.removeEventListener("blur", this.onBlur);
  }
}

export default Contenteditable;
