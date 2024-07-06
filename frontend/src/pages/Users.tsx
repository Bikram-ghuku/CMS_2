import { useEffect, useState } from 'react'
import SideNav from '../components/SideNav'
import TopNav from '../components/TopNav'
import { BACKEND_URL } from '../constants'
import { ToastContainer, toast } from 'react-toastify';
import { Link } from 'react-router-dom';
import "../styles/Users.scss"
import { Plus } from 'lucide-react';

type user = {
    uname:string,
    user_id:string,
    role:string
}
function Users() {
    const [users, setUsers] = useState<user[]>([])
    useEffect(() => {
        fetch(BACKEND_URL+'/user/all', {
            method:"GET",
            credentials:'include'
        }).then((data) => {
            if(data.ok){
                data.json().then((jsondata:user[]) => [
                    setUsers(jsondata)
                ])
            }else{
                toast.error("Loading Error", {
                    position: "bottom-center"
              })
            }
        })
    }, [])
    return (
        <div>
            <SideNav />
            <TopNav />
            <div className="user-main">
                <div className="user-title">Registered Users</div>
                <div className="user-actions">
                    <div className="user-search">
                        <input
                            placeholder='Enter Name to search'
                        />
                    </div>
                    <div className="user-add">
                        <button className='user-add-btn'>
                            <Plus /> New user
                        </button>
                    </div>
                </div>
                <div className="user-table">
                    <table>
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {
                                users.map((item, idx) => {

                                    return (
                                        <tr key={idx}>
                                            <td>{item.uname}</td>
                                            <td>{item.role}</td>
                                            <td>
                                                <Link to={"./forgot_pswd/"+item.user_id}>Forgot Password</Link>
                                            </td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            </div>
            <ToastContainer/>
        </div>
    )
}

export default Users