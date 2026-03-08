import streamlit as st

st.title("06) form : 제출 버튼 눌렀을때만 반영하기")

#form이 없으면 입력할 때마다 rerun이 계속해서 발생하므로
#입력을 모아서 submit 눌렀을때만 처리하고 싶을때 활용

with st.form("sighup_foem"):
    st.subheader("회원 가입 폼")
    username = st.text_input("아이디")
    password = st.text_input("비밀번호",type="password")
    age = st.number_input("나이", min_value=20,max_value=120,value=20)

    submitted = st.form_submit_button("제출")


if submitted:
    #입력 값 검증(예시)
    if not username.strip():
        st.error("username은 필수입니다.")
    elif len(password) < 4:
        st.warning("password는 4자 이상을 권장합니다.")
    else:
        st.success("제출 완료")
        st.write({"username":username,"age":int(age)})