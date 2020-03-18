class Body extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: []
    }
  }

  componentDidMount() {
    fetch('/api/v1/projects.json')
      .then((response) => { return response.json() })
      .then((data) => { this.setState({ projects: data }) });
  }

  render(){
    return(
      <div className='dashboard_container'>
        <table className='tbl' id='info'>
          <tbody>
            <tr className='tr-month'>
              <td>Projects/Tasks</td>
              <td className='target' colSpan='5'>Target</td>
              <td  className='actual' colSpan='2'>Actual</td>
            </tr>
            <AllProjectInfo projects={this.state.projects} />
          </tbody>
        </table>
        <table className='tbl' id='details'>

        </table>
      </div>
    )
  }
}
