import { useState } from "react";
import { Form } from "react-bootstrap";
import { useAtom } from "jotai";
import { selectAtom } from "../components/jotai";

const SideNav = ({list}) => {
    const [value, setValue] = useState("");
    const [selected,setSelected] = useAtom(selectAtom)

    return <>
        <Form.Control
            autoFocus
            placeholder="Type to filter..."
            onChange={(e) => setValue(e.target.value)}
            value={value}
        />
        <ul className="list-unstyled">
            {
                list.filter(x => x.name.includes(value))
                .map(x => <li onClick={e => setSelected(x)}>{x.name}</li>)
            }
        </ul>
    </>
}

export default SideNav;